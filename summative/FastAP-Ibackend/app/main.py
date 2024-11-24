# from fastapi import FastAPI
# from pydantic import BaseModel
# import pickle
# import numpy as np
# from sklearn.preprocessing import StandardScaler


# # Initialize FastAPI
# app = FastAPI()



# # Load pre-trained model and scalers

# model_path = "model/best_model.pkl"
# scaler_X_path = "model/scaler_X.pkl"
# scaler_y_path = "model/scaler_y.pkl"

# with open(model_path, "rb") as f:
#     model = pickle.load(f)

# with open(scaler_X_path, "rb") as f:
#     scaler_X = pickle.load(f)

# with open(scaler_y_path, "rb") as f:
#     scaler_y = pickle.load(f)

# # Define a request body for prediction
# class InputData(BaseModel):
#     Item_Potatoes: int
#     Area_United_Kingdoms: int
#     Item_Sweet_potatoes: int
#     Area_Japan: int
#     Years: int
#     average_rain_fall_mm_per_year: float
#     pesticides_tonnes: float
#     avg_temp: float

# @app.post("/predict/")
# async def predict(data: InputData):
#     # Prepare the input data as required by the model
#     input_data = np.array([
#         data.Item_Potatoes,
#         data.Area_United_Kingdoms,
#         data.Item_Sweet_potatoes,
#         data.Area_Japan,
#         data.Years,

#         data.average_rain_fall_mm_per_year,
#         data.pesticides_tonnes,
#         data.avg_temp
#     ]).reshape(1, -1)

#     # Scale the data
#     X_scaled = scaler_X.transform(input_data)

#     # Make prediction
#     prediction_scaled = model.predict(X_scaled)

#     # Reverse scale the prediction
#     prediction = scaler_y.inverse_transform(prediction_scaled.reshape(-1, 1))[0][0]

#     return {"predicted_yield": prediction}


from fastapi import FastAPI
from pydantic import BaseModel
import pickle
import numpy as np
from sklearn.preprocessing import StandardScaler

# Initialize FastAPI
app = FastAPI()

# Load your pre-trained model and scalers
model_path = "model/best-model.pkl"
scaler_X_path = "model/scaler_X.pkl"
scaler_y_path = "model/scaler_y.pkl"

with open(model_path, "rb") as f:
    model = pickle.load(f)

with open(scaler_X_path, "rb") as f:
    scaler_X = pickle.load(f)

with open(scaler_y_path, "rb") as f:
    scaler_y = pickle.load(f)

# Define a request body for prediction
class InputData(BaseModel):
    Item_Potatoes: int
    Area_United_Kingdoms: int
    Item_Sweet_potatoes: int
    Area_Japan: int
    Years: int
    average_rain_fall_mm_per_year: float
    pesticides_tonnes: float
    avg_temp: float

@app.post("/predict/")
async def predict(data: InputData):
    # Prepare the input data as required by the model
    input_data = np.array([[
        data.Item_Potatoes,
        data.Area_United_Kingdoms,
        data.Item_Sweet_potatoes,
        data.Area_Japan,
        data.Years,
        data.average_rain_fall_mm_per_year,
        data.pesticides_tonnes,
        data.avg_temp
    ]])

    # Scale the input data
    X_scaled = scaler_X.transform(input_data)

    # Make prediction using the model
    prediction_scaled = model.predict(X_scaled)

    # Reverse scale the prediction to get the original value
    prediction_original = scaler_y.inverse_transform(prediction_scaled.reshape(-1, 1))[0][0]

    # Return the result as JSON
    return {"predicted_yield": prediction_original}
