import pickle
import numpy as np
from sklearn.preprocessing import StandardScaler

# Load the model and scalers
model_path = "model/best_model.pkl"
scaler_X_path = "model/scaler_X.pkl"
scaler_y_path = "model/scaler_y.pkl"

def load_model():
    with open(model_path, "rb") as f:
        model = pickle.load(f)

    with open(scaler_X_path, "rb") as f:
        scaler_X = pickle.load(f)

    with open(scaler_y_path, "rb") as f:
        scaler_y = pickle.load(f)

    return model, scaler_X, scaler_y

def predict(data, model, scaler_X, scaler_y):
    input_data = np.array([data]).reshape(1, -1)
    X_scaled = scaler_X.transform(input_data)
    prediction_scaled = model.predict(X_scaled)
    prediction = scaler_y.inverse_transform(prediction_scaled.reshape(-1, 1))[0][0]
    return prediction
