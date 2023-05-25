FROM node:latest

WORKDIR /app
RUN yarn set version berry
# ENTRYPOINT ["bash"]
