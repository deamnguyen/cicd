#FROM node:12.7-alpine as lib
#RUN mkdir /app
#COPY lgsp-tb-ui/node_modules /app/node_modules
#RUN npm install -g @angular/cli

#-------------------------------

FROM deam2k/log-tthcc-ui-lib:1.0.1 as build
COPY lgsp-tb-ui/. /app/src
RUN mkdir /app/src/node_modules
RUN cp -r /app/lib/. /app/src/node_modules
WORKDIR /app/src
RUN ng build

FROM nginx:1.17.1-alpine as deploy
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/src/dist /usr/share/nginx/html

