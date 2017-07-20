FROM python:3.6
ENV PYTHONUNBUFFERED 1
EXPOSE 5000

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Install Project Requirements
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Copy Source Code
COPY . /usr/src/app

# Build NPM
WORKDIR /usr/src/app/namer/static/js/app/
RUN npm install
RUN npm run build
RUN chmod -R 777 node_modules

# Start Server
WORKDIR /usr/src/app/
CMD [ "python", "namer/wsgi.py" ]
