FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9 AS builder

WORKDIR /app

COPY  requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt



FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9-slim AS runtime

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

COPY . .

EXPOSE 5500


CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5500"]