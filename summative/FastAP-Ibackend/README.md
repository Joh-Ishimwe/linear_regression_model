
# Task 2: FastAPI Backend Development

This task involves creating a FastAPI backend to serve predictions from the trained crop yield prediction model.

---

## **Steps Completed**
1. Implemented the FastAPI backend.
2. Validated input data using Pydantic models.
3. Integrated the pre-trained Random Forest model.
4. Deployed the API on Render.
5. Tested the API using Swagger UI:https://fastapi-rm5x.onrender.com/docs

---

## **How to Run**
1. Install dependencies:
   ```bash
   pip install -r requirements.txt
## **Start Run**
   uvicorn app.main:app --reload
