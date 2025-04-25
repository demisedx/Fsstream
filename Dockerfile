# Use an official Python runtime as a base image
   FROM python:3.9-slim

   # Create a virtual environment and non-root user
   RUN python -m venv /opt/venv
   ENV PATH="/opt/venv/bin:$PATH"

   # Create a non-root user and set permissions
   RUN useradd -m appuser && chown -R appuser /opt/venv
   USER appuser

   # Set the working directory
   WORKDIR /app

   # Copy requirements and install dependencies
   COPY --chown=appuser:appuser requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt

   # Copy the rest of the app
   COPY --chown=appuser:appuser . .

   # Run the bot
   CMD ["python3", "-m", "bot"]
