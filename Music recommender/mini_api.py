import random
from flask import Flask, request, jsonify
from flask_cors import CORS
app = Flask(__name__)

# List of song titles to randomly select from.
song_titles = [
    "Silent Night",
    "Tanssi vaan",
    "No One Could Ever",
    "Si Vos QuerÃ©s",
    'We Have Got Love',
    '2 Da Beat Chyall',
    'Goodbye',
    "Mama_ mama can't you see ?",
    "L'antarctique",
    'El hijo del pueblo',
    'Cold Beer feat. Prince Metropolitan',
    'Pilots',
    'N Gana',
    '(Looking For) The Heart Of Saturday',
    'Ethos of Coercion',
    'Rock-N-Rule',
    'La bola extra',
    'I Made It Over',
    'Debussy : 12 Etudes : VI Pour les huit doigts',
    'Nervous',
    'In The Journey',
    'Fuckin Ethic People (999)',
    "I'm Ready",
    'Take As Needed',
    'Autumn In The Mind (Acoustic Version)',
    'Tequila',
    'All For A Purpose (Speak Life Album Version)',
    'C On',
    'Raspberry Beret (LP Version)',
    'All of the same blood',
    'One Little Too Little',
    'Cockleshell Heroes',
    'Trancesequence',
    'Wonderful Stash',
    'La filo',
    'Throw It Away',
    'Before He Kissed Me',
    'Blessed',
    'Goa Amsterdam ',
    'Disaster [Demo Version]',
    'Night And Day ',
    'Passione ',
    'My Everything [Screwed] (feat. Trae The Truth)',
    'Scream',
    'The Man Delusion ',
    'He Is Not Silent (Out Of The Grey Album Version) ',
    'Mule Boogie',
    'Dancing In The Dark',
    'Mad About You ',
    'Heartaches',
    'Pain Over Acceptance',
    "Ships That Don't Come In",
    'Saturday Night (LP Version) ',
    'I Just Want To Be With You This Christmas ',
    'On the Surface Remember(Walking InThe Sand )Just Another Woman untitled',
    'Bakslag',
    'The New Way',
    'Suffer',
    'Bring It',
    'You And I',
    'Sitting In My Window (Finis Tasby BMI)',
    'Raid The Itch',
    'The Rest of the Night',
    'Ride',
    'Passion Protein',
    'Redemption',
    'Dame Tus Besos ',
    "Don't Prolong the Agony(Bonus Track)",
    'Dalny svet(bonus 2003)',
    'Alice in Wonderland: ActI:The Caucus Race',
    'Le mauvais coton',
    'Love Can Change feat. Nadine Sutherland',
    '.Subtek.',
    'Dream Of Love.',
    'Lucy Fears the Morning Star.',
    'Fool on the Hill',
    'Baiting the Public.',
    'Death Acceptor.',
    'Wipeout.',
    'Fick uns.',
    'Wir Sind Die Jungsfeat.Din&Smexer',
    'Make Dat Monet ',
    'Two Legged Sheep',
    'Chi Sei Adesso',
    'Stuck On My Vision',
    'Joku muu',
    'Whaleface(Instrumental)',
    'Brown Paper Bag',
    'You Needed Me',
    ]

CORS(app)

# Endpoint to receive u_uid and song_id values from Flutter app.
@app.route('/recommend', methods=['POST'])
def recommend():
    if request.method == 'POST':
        # Retrieve the values of u_uid and song_id from the JSON payload sent by the client.
        u_uid = request.json['u_uid']
        song_id = request.json['song_id']

        # Select a random song title from our list.
        recommended_song_title = random.sample(song_titles,k=10)

        print(f"Received recommendation for user {u_uid} and song {song_id}")
        print(f"Suggesting randomized title: {recommended_song_title}")

        # Send response back to the client indicating that we have received their recommendation successfully,
        # along with a randomly selected recommended song title as part of JSON-encoded response body.
        response_body_dict = {
            'message': 'Recommendation received successfully',
            'recommended_song_title': recommended_song_title
        }

        return jsonify(response_body_dict), 200


if __name__ == '__main__':
	app.run(debug=True)