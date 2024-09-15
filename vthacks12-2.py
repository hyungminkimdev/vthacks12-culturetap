from flask import Flask, request, jsonify
import json
import openai

# Initialize Flask app
app = Flask(__name__)

# Set your OpenAI API Key explicitly in the code
openai.api_key = 'API_KEY_OPENAI'

# Function to run OpenAI chat completion
def run_openai_chat(prompt_messages):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=prompt_messages,
        max_tokens=500,
        temperature=0.7
    )
    return response['choices'][0]['message']['content']

# Function to transform user data
def transform_user_data(basic_user_data):
    desired_json_format = """
    {
      "user_profile": {
        "user_id": "generated_id",
        "name": "",
        "pronouns": "",
        "age": ,
        "nationality": "",
        "preferred_languages": [],
        "cultural_background": {
          "country_of_origin": "",
          "current_residence": "",
          "frequently_visited_countries": [],
          "favorite_holidays": [],
          "traditional_dishes": []
        },
        "device_data": {
          "system_language": "",
          "input_languages": [],
          "location_services": {
            "current_location": {
              "latitude": ,
              "longitude": ,
              "city": "",
              "country": ""
            },
            "recent_locations": []
          },
          "calendar_data": {
            "upcoming_events": []
          }
        },
        "social_profiles": {
          "linkedin": "",
          "twitter": ""
        },
        "quiz_history": {
          "last_completed_quiz": {
            "quiz_id": "",
            "score": ,
            "topics": [],
            "date_taken": ""
          },
          "performance_metrics": {
            "average_score": ,
            "total_quizzes_taken": ,
            "quiz_categories": []
          }
        }
      }
    }
    """
    
    prompt_messages = [
        {"role": "system", "content": "You are a helpful assistant that enriches user data by assuming cultural and identity information."},
        {"role": "user", "content": f"Here is the basic user data: {json.dumps(basic_user_data)}. Please generate an enriched JSON in the following format: {desired_json_format}. Ensure all generated data is plausible and respectful."}
    ]

    enriched_json = run_openai_chat(prompt_messages)

    print(enriched_json)

    # Parse the generated JSON
    try:
        enriched_data = json.loads(enriched_json)
    except json.JSONDecodeError:
        return None, "Failed to parse the generated JSON."

    return enriched_data, None

# Route to generate quiz based on user profile
@app.route('/generate_quiz_based_on_profile', methods=['POST'])
def generate_quiz_based_on_profile():
    basic_user_data = request.json.get('basic_user_data')

    # First, transform the user data
    enriched_user_data, error = transform_user_data(basic_user_data)
    if error:
        return jsonify({"error": error}), 400

    # Now, generate the quiz based on the transformed user data
    prompt_messages = [
        {"role": "system", "content": "You are an AI that generates personalized quiz questions based on user profile data."},
        {"role": "user", "content": f"Generate a personalized quiz based solely on the following user profile data in JSON format:\n\n{json.dumps(enriched_user_data, indent=2)}\n\nEnsure all questions are respectful, culturally sensitive, and engaging.can you build a quiz which doesn't seem static but is more personality based it is quiz for other a person who they recently talked with / connected with and this person who they connected with would get points if they really know the person. Make sure the quiz generated is in JSON format that can be straight away parsed."}
    ]

    quiz_json = run_openai_chat(prompt_messages)

    try:
        quiz_data = json.loads(quiz_json)
    except json.JSONDecodeError:
        return jsonify({"error": "Failed to parse the generated quiz JSON."}), 400

    return jsonify(quiz_data)

# Route to generate quiz based on user profile and event data
@app.route('/generate_quiz_based_on_event', methods=['POST'])
def generate_quiz_based_on_event():
    basic_user_data = request.json.get('basic_user_data')
    event_data = request.json.get('event_data')
    
    # First, transform the user data
    enriched_user_data, error = transform_user_data(basic_user_data)
    if error:
        return jsonify({"error": error}), 400
    
    # Mock additional fields related to the hackathon event
    user_data_for_event = {
        "programming_languages": ["Python", "JavaScript"],
        "projects_interested_in": ["AI-powered apps", "Blockchain"],
        "available_tracks": ["Best Startup Hack", "Best Hack Supporting Diversity & Inclusion", "AI for Good"],
        "preferred_track": "Best Startup Hack"
    }

    prompt_messages = [
        {"role": "system", "content": "You are an AI that generates personalized quiz questions based on user profile data and additional event-specific data."},
        {"role": "user", "content": f"Generate a personalized quiz for the following user profile and event-specific data in JSON format. Ensure the quiz contains questions relevant to the event.\n\nUser Profile Data:\n{json.dumps(enriched_user_data, indent=2)}\n\nAdditional Hackathon Event Data:\n{json.dumps(user_data_for_event, indent=2)}\n\nEvent Data:\n{json.dumps(event_data, indent=2)}\n\nThe quiz should contain multiple-choice questions, including questions like which track the user might be most interested in."}
    ]

    quiz_json = run_openai_chat(prompt_messages)

    try:
        event_quiz_data = json.loads(quiz_json)
    except json.JSONDecodeError:
        return jsonify({"error": "Failed to parse the generated quiz JSON."}), 400

    # Return the final quiz
    return jsonify(event_quiz_data)

# Route to generate phrases or slang based on two users' languages and countries
@app.route('/generate_phrases', methods=['POST'])
def generate_phrases():
    # Get data for both people from the request
    person1_data = request.json.get('person1')
    person2_data = request.json.get('person2')

    if not person1_data or not person2_data:
        return jsonify({"error": "Both person1 and person2 data are required."}), 400

    person1_languages = person1_data.get('languages')
    person1_countries = person1_data.get('countries')

    person2_languages = person2_data.get('languages')
    person2_countries = person2_data.get('countries')

    if not person1_languages or not person1_countries or not person2_languages or not person2_countries:
        return jsonify({"error": "Languages and countries are required for both person1 and person2."}), 400

    # Prepare the OpenAI prompt with your custom logic
    prompt_messages = [
        {"role": "system", "content": "You are an AI that helps generate phrases to improve cross-cultural communication."},
        {"role": "user", "content": f"""
        person 1 has relations with the following countries and languages -  
        "languages": {json.dumps(person1_languages)}, 
        "countries": {json.dumps(person1_countries)}

        person 2 has relations with the following countries and languages - 
        "languages": {json.dumps(person2_languages)}, 
        "countries": {json.dumps(person2_countries)}

        Try and come up with phrases or slang that reflect greetings, respect, and inclusion for each other and also provide translations for them in their own language, especially focusing on languages that are not common amongst them.

        The reason I am coming up with phrases is both should learn how to interact with each other better so person 1 should know phrases in a language that person 2 most probably uses in his daily life and also get a translation of that in his own language so that he knows what it exactly is. 

        Also, person 1 should see the phrase in phonetic notation and script that he understands. This same thing should be available for person 2. Make sure these phrases are respectful and easy to understand.
        
        Ensure the response is in JSON and not a string.
        """}
    ]

    # Run the OpenAI chat completion to generate the phrases
    phrases_json = run_openai_chat(prompt_messages)

    print(phrases_json)

    try:
        phrases_data = json.loads(phrases_json)
    except json.JSONDecodeError:
        return jsonify({"error": "Failed to parse the generated phrases JSON."}), 400

    return jsonify(phrases_data)

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True, host='172.29.249.105', port=8085)
