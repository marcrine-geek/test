# Use an appropriate base image
FROM python:3.7-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y default-libmysqlclient-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the port on which your Flask app will run
EXPOSE 80

# Command to run the Flask application
CMD ["python", "main.py"]
