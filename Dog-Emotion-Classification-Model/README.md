
# Dog Emotion Classification Model Installation Guide

## StepUp Flask Api

1. Clone the Repository
- Clone the project from the repository to your local machine:
``` bash 
   git clone https://github.com/AshfordR/Dog-Emotion-Classification-Complete.git

   cd Dog-Emotion-Classification-Model
```
2. Create and Activate Virtual Environment
- Create a virtual environment:
```bash
    python -m venv .venv
```
- Activate the virtual environment:
``` bash
    On Windows:  .venv\Scripts\activate

    On macOS/Linux: source .venv/bin/activate
```
3. Install Dependencies
- Install the necessary Python packages from `requirements.txt`:
``` bash 
    pip install -r requirements.txt
```
4. Run the Flask App
- Start the Flask app:
``` bash
    flask run --host=0.0.0.0
```
This will run the app on http://198.X.X.X:5000. You should see output similar to:
 * Running on http://198.X.X.X:5000
