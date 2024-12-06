# # from flask import Flask, request, jsonify,render_template
# # import librosa
# # import numpy as np
# # import pickle
# # import os
# # from werkzeug.utils import secure_filename
# # from flask_cors import CORS
# # from moviepy.editor import VideoFileClip

# # # Initialize Flask app
# # app = Flask(__name__)
# # CORS(app)  # Enable CORS for all routes

# # # Load the trained model and RFE selector
# # with open('model/dog_bark_classifier.pkl', 'rb') as model_file:
# #     model = pickle.load(model_file)

# # with open('model/rfe_selector.pkl', 'rb') as rfe_file:
# #     rfe = pickle.load(rfe_file)

# # # Function to extract features from audio
# # def extract_features(y, sr):
# #     mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=10)
# #     chroma = librosa.feature.chroma_stft(y=y, sr=sr)
# #     spectral_contrast = librosa.feature.spectral_contrast(y=y, sr=sr)
# #     return np.concatenate((np.mean(mfccs.T, axis=0),
# #                            np.mean(chroma.T, axis=0),
# #                            np.mean(spectral_contrast.T, axis=0)))

# # # Default route to show backend is running
# # @app.route('/')
# # def index():
# #     return render_template('index.html')
# # @app.route('/predict', methods=['POST'])
# # def predict():
# #     if 'videofile' not in request.files:
# #         return jsonify({"status": "error", "message": "No file part in the request"}), 400

# #     file = request.files['videofile']
# #     print(f"Received file: {file.filename}, mimetype: {file.mimetype}")

# #     if file and (file.mimetype in ['video/mp4', 'application/octet-stream'] or file.filename.endswith('.mp4')):
# #         try:
# #             # Save and process the file
# #             filename = secure_filename(file.filename)
# #             filepath = os.path.join('uploads', filename)
# #             file.save(filepath)

# #             # Extract audio
# #             video = VideoFileClip(filepath)
# #             audio_path = filepath.replace(".mp4", ".wav")
# #             video.audio.write_audiofile(audio_path)
# #             print(f"Audio saved at: {audio_path}")

# #             # Load and extract features
# #             try:
# #                 y, sr = librosa.load(audio_path, sr=22050)
# #                 features = extract_features(y, sr)
# #                 features_rfe = rfe.transform(features.reshape(1, -1))
# #                 print(f"Extracted features: {features_rfe}")
# #             except Exception as e:
# #                 print(f"Error during feature extraction: {e}")
# #                 return jsonify({"status": "error", "message": f"Feature extraction failed: {e}"}), 500

# #             # Make prediction
# #             try:
# #                 prediction = model.predict(features_rfe)[0]
# #                 print(f"Prediction: {prediction}")
# #                 return jsonify({"status": "success", "prediction": prediction})
# #             except Exception as e:
# #                 print(f"Error during prediction: {e}")
# #                 return jsonify({"status": "error", "message": f"Prediction failed: {e}"}), 500

# #         except Exception as e:
# #             print(f"Error processing video: {e}")
# #             return jsonify({"status": "error", "message": f"Processing failed: {e}"}), 500

# #     return jsonify({"status": "error", "message": "Invalid file type."}), 400




# # if __name__ == '__main__':
# #     # Ensure uploads folder exists
# #     if not os.path.exists('uploads'):
# #         os.makedirs('uploads')
# #     app.run(debug=True, host='0.0.0.0', port=5000)





# from flask import Flask, request, jsonify, render_template, redirect, url_for
# import librosa
# import numpy as np
# import pickle
# import os
# import nbformat
# from nbconvert.preprocessors import ExecutePreprocessor
# import subprocess
# from werkzeug.utils import secure_filename
# from flask_cors import CORS
# from moviepy.editor import VideoFileClip

# print(f"Current working directory: {os.getcwd()}")
# # Initialize Flask app
# app = Flask(__name__)
# CORS(app)  # Enable CORS for all routes

# # Hardcoded login credentials
# USERNAME = 'admin'
# PASSWORD = 'admin123'

# if not os.path.exists('processed_dataset'):
#     os.makedirs('processed_datasets')

# # Folder structure for classes
# classes = ['Happy', 'Pain', 'Howling', 'Aggressive', 'Unknown']

# # Load the trained model and RFE selector
# with open('model/dog_bark_classifier.pkl', 'rb') as model_file:
#     model = pickle.load(model_file)

# with open('model/rfe_selector.pkl', 'rb') as rfe_file:
#     rfe = pickle.load(rfe_file)

# # Function to extract features from audio
# def extract_features(y, sr):
#     mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=10)
#     chroma = librosa.feature.chroma_stft(y=y, sr=sr)
#     spectral_contrast = librosa.feature.spectral_contrast(y=y, sr=sr)
#     return np.concatenate((np.mean(mfccs.T, axis=0),
#                            np.mean(chroma.T, axis=0),
#                            np.mean(spectral_contrast.T, axis=0)))

# # Login route (this will be shown when you visit the root URL)
# @app.route('/', methods=['GET', 'POST'])
# def login():
#     if request.method == 'POST':
#         username = request.form['username']
#         password = request.form['password']
        
#         # Check if credentials match
#         if username == USERNAME and password == PASSWORD:
#             return redirect(url_for('dashboard'))  # Redirect to dashboard after login
#         else:
#             return render_template('login.html', error="Invalid credentials. Please try again.")
#     return render_template('login.html')

# # Dashboard page after login (You can modify this page as per your needs)
# @app.route('/dashboard')
# def dashboard():
#     return render_template('dashboard.html')


# @app.route('/upload_audio', methods=['POST'])
# def upload_audio():
#     class_name = request.form['class']
#     audio_file = request.files.get('audio')

#     # Validate class
#     if class_name not in classes:
#         return jsonify({"status": "error", "message": "Invalid class selected"}), 400

#     # Ensure the file is a .wav
#     if not audio_file or not audio_file.filename.endswith('.wav'):
#         return jsonify({"status": "error", "message": "Only .wav files are allowed"}), 400

#     # Create the folder if it doesn't exist
#     folder_path = os.path.join('processed_dataset', class_name)
#     if not os.path.exists(folder_path):
#         os.makedirs(folder_path)

#     # Save the audio file to the corresponding class folder
#     try:
#         file_path = os.path.join(folder_path, audio_file.filename)
#         audio_file.save(file_path)
#         return jsonify({"status": "success", "message": "File uploaded successfully!"}), 200
#     except Exception as e:
#         return jsonify({"status": "error", "message": f"File upload failed: {str(e)}"}), 500



# @app.route('/train_model', methods=['POST'])
# def train_model():
#     try:
#         notebook_path = 'C:/Users/asfor/OneDrive/Desktop/Backend-rebder - Copy/dog_model.ipynb'
#         with open(notebook_path, 'r', encoding='utf-8') as notebook_file:
#             notebook = nbformat.read(notebook_file, as_version=4)
#             executor = ExecutePreprocessor(timeout=600, kernel_name='python3')

#             # Execute the notebook
#             executor.preprocess(notebook, {'metadata': {'path': os.path.dirname(notebook_path)}})

#         return jsonify({"status": "success", "message": "Model training completed successfully!"}), 200

#     except Exception as e:
#         print(f"Error executing notebook: {e}")
#         return jsonify({"status": "error", "message": f"Error training model: {e}"}), 500



# # Video prediction route
# @app.route('/predict', methods=['POST'])
# def predict():
#     if 'videofile' not in request.files:
#         return jsonify({"status": "error", "message": "No file part in the request"}), 400

#     file = request.files['videofile']
#     print(f"Received file: {file.filename}, mimetype: {file.mimetype}")

#     if file and (file.mimetype in ['video/mp4', 'application/octet-stream'] or file.filename.endswith('.mp4')):

#         try:
#             # Save and process the file
#             filename = secure_filename(file.filename)
#             filepath = os.path.join('uploads', filename)
#             file.save(filepath)

#             # Extract audio
#             video = VideoFileClip(filepath)
#             audio_path = filepath.replace(".mp4", ".wav")
#             video.audio.write_audiofile(audio_path)
#             print(f"Audio saved at: {audio_path}")

#             # Load and extract features
#             try:
#                 y, sr = librosa.load(audio_path, sr=22050)
#                 features = extract_features(y, sr)
#                 features_rfe = rfe.transform(features.reshape(1, -1))
#                 print(f"Extracted features: {features_rfe}")
#             except Exception as e:
#                 print(f"Error during feature extraction: {e}")
#                 return jsonify({"status": "error", "message": f"Feature extraction failed: {e}"}), 500

#             # Make prediction
#             try:
#                 prediction = model.predict(features_rfe)[0]
#                 print(f"Prediction: {prediction}")
#                 return jsonify({"status": "success", "prediction": prediction})
#             except Exception as e:
#                 print(f"Error during prediction: {e}")
#                 return jsonify({"status": "error", "message": f"Prediction failed: {e}"}), 500

#         except Exception as e:
#             print(f"Error processing video: {e}")
#             return jsonify({"status": "error", "message": f"Processing failed: {e}"}), 500

#     return jsonify({"status": "error", "message": "Invalid file type."}), 400

# if __name__ == '__main__':
#     # Ensure uploads folder exists
#     if not os.path.exists('uploads'):
#         os.makedirs('uploads')
#     app.run(debug=True, host='0.0.0.0', port=5000)



from flask import Flask, request, jsonify, render_template, redirect, url_for, session
import librosa
import numpy as np
import pickle
import os
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor
from werkzeug.utils import secure_filename
from flask_cors import CORS
from moviepy.editor import VideoFileClip

# print(f"Current working directory: {os.getcwd()}")
# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Hardcoded login credentials
USERNAME = 'admin'
PASSWORD = 'admin123'

app.secret_key = 'ashreb'  # Required for session management

if not os.path.exists('processed_dataset'):
    os.makedirs('processed_datasets')

# Folder structure for classes
classes = ['Happy', 'Pain', 'Howling', 'Aggressive', 'Unknown']

# Load the trained model and RFE selector
with open('model/dog_bark_classifier.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

with open('model/rfe_selector.pkl', 'rb') as rfe_file:
    rfe = pickle.load(rfe_file)

# Function to extract features from audio
def extract_features(y, sr):
    mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=10)
    chroma = librosa.feature.chroma_stft(y=y, sr=sr)
    spectral_contrast = librosa.feature.spectral_contrast(y=y, sr=sr)
    return np.concatenate((np.mean(mfccs.T, axis=0),
                           np.mean(chroma.T, axis=0),
                           np.mean(spectral_contrast.T, axis=0)))

# Login route (this will be shown when you visit the root URL)
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        # Check if credentials match
        if username == USERNAME and password == PASSWORD:
            session['logged_in'] = True  # Store the login state in the session
            return redirect(url_for('dashboard'))  # Redirect to dashboard after login
        else:
            return render_template('login.html', error="Invalid credentials. Please try again.")
    return render_template('login.html')

# Dashboard page after login (You can modify this page as per your needs)
@app.route('/dashboard')
def dashboard():
    if 'logged_in' not in session:
        return redirect(url_for('login'))  # Redirect to login if not logged in
    return render_template('dashboard.html')

@app.route('/get_folder_structure', methods=['GET'])
def get_folder_structure():
    if 'logged_in' not in session:
        return redirect(url_for('login'))  # Redirect to login if not logged in

    dataset_path = 'processed_dataset'
    structure = {}
    
    # Loop through the classes in the processed_dataset folder
    for class_name in os.listdir(dataset_path):
        class_path = os.path.join(dataset_path, class_name)
        if os.path.isdir(class_path):
            num_files = len([f for f in os.listdir(class_path) if f.endswith('.wav')])
            structure[class_name] = num_files
    
    return jsonify({
        "status": "success",
        "structure": structure
    })

@app.route('/upload_audio', methods=['POST'])
def upload_audio():
    if 'logged_in' not in session:
        return redirect(url_for('login'))  # Redirect to login if not logged in

    class_name = request.form['class']
    audio_file = request.files.get('audio')

    # Validate class
    if class_name not in classes:
        return jsonify({"status": "error", "message": "Invalid class selected"}), 400

    # Ensure the file is a .wav
    if not audio_file or not audio_file.filename.endswith('.wav'):
        return jsonify({"status": "error", "message": "Only .wav files are allowed"}), 400

    # Create the folder if it doesn't exist
    folder_path = os.path.join('processed_dataset', class_name)
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)

    # Save the audio file to the corresponding class folder
    try:
        file_path = os.path.join(folder_path, audio_file.filename)
        audio_file.save(file_path)
        return jsonify({"status": "success", "message": "File uploaded successfully!"}), 200
    except Exception as e:
        return jsonify({"status": "error", "message": f"File upload failed: {str(e)}"}), 500

@app.route('/get_performance_metrics', methods=['GET'])
def get_performance_metrics():
    if 'logged_in' not in session:
        return redirect(url_for('login'))  # Redirect to login if not logged in

    try:
        # Load the model (or metrics) from the pickle file
        with open('model/performance_metrics.pkl', 'rb') as f:
            model = pickle.load(f)

        # Assuming the model object is a dictionary with the performance metrics
        if isinstance(model, dict):
            # Convert NumPy types to native Python types (float, int) and multiply by 100
            metrics = {key: round(float(value) * 100, 2) if isinstance(value, (np.float64, np.int64, float)) else value for key, value in model.items()}

            # Return the metrics as a response
            return jsonify({'status': 'success', 'metrics': metrics})
        else:
            return jsonify({'status': 'error', 'message': 'Loaded model is not in the expected format (dict)'}), 500

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

@app.route('/train_model', methods=['POST'])
def train_model():
    if 'logged_in' not in session:
        return redirect(url_for('login'))  # Redirect to login if not logged in

    try:
        notebook_path = 'C:/Users/asfor/OneDrive/Desktop/Backend-rebder - Copy/dog_model.ipynb'
        with open(notebook_path, 'r', encoding='utf-8') as notebook_file:
            notebook = nbformat.read(notebook_file, as_version=4)
            executor = ExecutePreprocessor(timeout=600, kernel_name='python3')

            # Execute the notebook
            executor.preprocess(notebook, {'metadata': {'path': os.path.dirname(notebook_path)}})

        return jsonify({"status": "success", "message": "Model training completed successfully!"}), 200

    except Exception as e:
        return jsonify({"status": "error", "message": f"Error training model: {e}"}), 500

# Video prediction route
@app.route('/predict', methods=['POST'])
def predict():
    if 'videofile' not in request.files:
        return jsonify({"status": "error", "message": "No file part in the request"}), 400

    file = request.files['videofile']
    if file and (file.mimetype in ['video/mp4', 'application/octet-stream'] or file.filename.endswith('.mp4')):

        try:
            # Save and process the file
            filename = secure_filename(file.filename)
            filepath = os.path.join('uploads', filename)
            file.save(filepath)

            # Extract audio
            video = VideoFileClip(filepath)
            audio_path = filepath.replace(".mp4", ".wav")
            video.audio.write_audiofile(audio_path)

            # Load and extract features
            try:
                y, sr = librosa.load(audio_path, sr=22050)
                features = extract_features(y, sr)
                features_rfe = rfe.transform(features.reshape(1, -1))

            except Exception as e:
                return jsonify({"status": "error", "message": f"Feature extraction failed: {e}"}), 500

            # Make prediction
            try:
                prediction = model.predict(features_rfe)[0]
                return jsonify({"status": "success", "prediction": prediction})
            except Exception as e:
                return jsonify({"status": "error", "message": f"Prediction failed: {e}"}), 500

        except Exception as e:
            return jsonify({"status": "error", "message": f"Processing failed: {e}"}), 500

    return jsonify({"status": "error", "message": "Invalid file type."}), 400

@app.route('/logout')
def logout():
    session.pop('logged_in', None)  # Remove the login session
    return redirect(url_for('login'))  # Redirect to login

if __name__ == '__main__':
    # Ensure uploads folder exists
    if not os.path.exists('uploads'):
        os.makedirs('uploads')
    app.run(debug=True, host='0.0.0.0', port=5000)
