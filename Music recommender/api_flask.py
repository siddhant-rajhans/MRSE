from flask import Flask,request,jsonify
import pandas as pd 
import numpy as np 
import joblib 
from recommenders import popularity_recommender_py,item_similarity_recommender_py 
app = Flask(__name__)

# # Load dumped popularity recommender model from .pkl file.
# popularity_rec = joblib.load("assets\pop_recommender_model.pkl")

# # Load dumped item similarity recommender model from .pkl file.
# item_similarity_rec = joblib.load("assets\item_sim_recommnder_model.pkl")


# Load dumped popularity recommender model from .pkl file.
popularity_rec = popularity_recommender_py()

# Load dumped item similarity recommender model from .pkl file.
item_similarity_rec = item_similarity_recommender_py()


@app.route('/predict', methods=['POST'])
def predict():
    
    # get data from request body (a list of song titles)
    songs_list = request.json['songs']
    
    # generate recommendations using both models and merge results into one list
    pop_predictions = popularity_rec.recommend_songs(songs_list)   # this method should be implemented in your PopularityRecommendor class.
    sim_predictions = item_similarity_rec.recommend_songs(songs_list)  # this method should be implemented in your ItemSimilarityRecommender class.
    recommendations = list(set(pop_predictions + sim_predictions))
    
    return jsonify({'recommendations': recommendations})

if __name__ == '__main__':
    app.run(debug=True)