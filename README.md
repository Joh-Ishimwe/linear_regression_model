
# Crop Yield Prediction Project

This repository contains the complete Crop Yield Prediction Project, developed as part of a summative assignment. The project combines Linear regression model development, FastAPI development, and mobile app implementation to predict crop yields based on environmental and agricultural factors.

---

## **Project Overview**
1. **Task 1:** Linear regression Model Development  
   - Built and optimized machine learning models to predict crop yield using the *Crop Yield Prediction Dataset* from Kaggle. https://www.kaggle.com/datasets/mrigaankjaswal/crop-yield-prediction-dataset/data
   - Compared Linear Regression, Decision Tree, and Random Forest algorithms to select the best model.
   - Google colab of notebook: https://colab.research.google.com/drive/1AXeDtGu2T0aw0SwvLJK44nELWdK6eSSg?usp=sharing
     **Read more on it in the READMe inside its directory**

2. **Task 2:** FastAPI Development  
   - Developed a FastAPI for making predictions using the trained model.
   - Implemented input validation with Pydantic and tested the API using Swagger UI.
   - Deployed the API on Render. https://fastapi-rm5x.onrender.com/docs
     **Read more on it in the READMe inside its directory**

3. **Task 3:** Mobile App Development  
   - Developed a Flutter mobile app that connects to the FastAPI and makes crop yield predictions.
   - The Figma design : https://www.figma.com/design/MxoAOSFXKB7azCbUcSEhEW/Wildlife-Activity-Predictor?node-id=0-1&t=qZiQdCtCC99BJ7tF-1
     **Read more on it and about how to run it in the READMe inside its directory**

3. **Video link:** https://www.youtube.com/shorts/-o1_xM6pWrY

---

## **Dataset**
The dataset used is the [Crop Yield Prediction Dataset](https://www.kaggle.com/datasets/mrigaankjaswal/crop-yield-prediction-dataset/data) from Kaggle. It contains data about:
- **Area (Country)**
- **Item (Crop)**
- **Year**
- **hg/ha_yield**: target variable, yield in hectograms per hectare
- **average_rain_fall_mm_per_year**
- **pesticides_tonnes**
- **avg_temp**
---


## **Technologies Used**
- **Machine Learning**: Python, scikit-learn, pandas, numpy
- **Backend**: FastAPI, Pydantic, Render deployment
- **Mobile App**: Flutter, Dart
- **Others**: Swagger UI, MinMaxScaler, pickle for saving models

---

## **Setup Instructions**
1. Clone the repository:
   ```bash
   git clone https://github.com/Joh-Ishimwe/linear_regression_model
   cd summative


