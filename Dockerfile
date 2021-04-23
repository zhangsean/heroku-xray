FROM nginx:alpine
ADD entrypoint.sh /
CMD /entrypoint.sh
