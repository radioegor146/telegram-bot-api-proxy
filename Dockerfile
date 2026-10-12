FROM nginx:1.27-alpine

COPY nginx.conf.template /etc/nginx/nginx.conf.template

CMD ["/bin/sh", "-c", "\
    : \"${SECRET_PREFIX:?SECRET_PREFIX is required}\"; \
    case \"$SECRET_PREFIX\" in \
      *[!a-zA-Z0-9_-]*) echo 'Invalid SECRET_PREFIX' >&2; exit 1;; \
    esac; \
    envsubst '${SECRET_PREFIX}' \
      < /etc/nginx/nginx.conf.template \
      > /etc/nginx/nginx.conf; \
    exec nginx -g 'daemon off;' \
"]