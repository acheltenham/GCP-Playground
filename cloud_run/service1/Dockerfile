## Image
FROM python:3.10-slim
# copy the requirements file used for dependencies
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy the rest of the working directory contents into the container at /app
COPY . .

# Run app.py when the container launches
ENTRYPOINT ["python", "main.py"]

## Build manually to keep the build process separate from the config process
# gcloud builds submit --pack image=gcr.io/udemy-labs/service1