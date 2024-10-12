# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install Flask
RUN pip install Flask

# Copy the Flask app code into the container
COPY hello_world.py .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["python", "hello_world.py"]
