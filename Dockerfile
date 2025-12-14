FROM node:22

WORKDIR /srv/liberama

COPY . ./

RUN apt-get update && apt-get install -y 7zip libreoffice poppler-utils djvulibre-bin libtiff-tools graphicsmagick-imagemagick-compat zip
# RUN apt update && apt install -y libgl1-mesa-glx libxdamage1 libegl1 libxkbcommon0 libopengl0 wget xz-utils libxcb-cursor0

# calibre тут пока не получилось завести
# Set environment variable for the installation directory
ENV CALIBRE_INSTALL_DIR="/data/liberama/calibre"
# Add the installation directory to the PATH
ENV PATH="${PATH}:${CALIBRE_INSTALL_DIR}/bin:${CALIBRE_INSTALL_DIR}"
# RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin install_dir=/data/liberama/calibre isolated=y

RUN rm -rf $APPDIR/public/*
RUN npm i && npm run build:client && node build/prepkg.js linux
RUN rm ./server/config/application_env; exit 0

EXPOSE 44080

CMD node server  --app-dir=$APPDIR