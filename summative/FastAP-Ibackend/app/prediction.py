from model import load_model, predict

# Load the model and scalers
model, scaler_X, scaler_y = load_model()

def get_prediction(data):
    return predict(data, model, scaler_X, scaler_y)
