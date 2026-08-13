FROM python:3.14-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r  requirements.txt 

FROM python:3.14-slim
WORKDIR /app

COPY --from=builder /root/.local /root/.local
RUN pip install --no-cache-dir --user --upgrade  setuptools>=78.1.1 msgpack>=1.2.1
ENV PATH=/root/.local/bin:$PATH
COPY . .

RUN useradd -m ram && chown -R ram /app /root/.local
USER ram 

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000')" || exit 1
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["app.py"]

