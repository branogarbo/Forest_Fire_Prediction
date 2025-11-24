FROM python:alpine

WORKDIR /code
COPY . .
RUN python3 -m venv .venv
RUN source .venv/bin/activate
RUN pip install -r requirements.txt

EXPOSE 8888

CMD [ "jupyter-notebook" ]