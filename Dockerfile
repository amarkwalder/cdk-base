FROM alpine:3.4
MAINTAINER André Markwalder <andre.markwalder@gmail.com>

ENV	GLIBC_GITHUB_USER=sgerrand \
	GLIBC_PKG_VERSION=2.23-r3 \
        LANG=en_US.UTF8

WORKDIR	/tmp

RUN	apk --update upgrade && \
    apk add --no-cache --update-cache curl ca-certificates bash tzdata && \
	curl -Lo /etc/apk/keys/${GLIBC_GITHUB_USER}.rsa.pub "https://github.com/${GLIBC_GITHUB_USER}/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/${GLIBC_GITHUB_USER}.rsa.pub" && \
	curl -Lo glibc-${GLIBC_PKG_VERSION}.apk "https://github.com/${GLIBC_GITHUB_USER}/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/glibc-${GLIBC_PKG_VERSION}.apk" && \
	curl -Lo glibc-bin-${GLIBC_PKG_VERSION}.apk "https://github.com/${GLIBC_GITHUB_USER}/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/glibc-bin-${GLIBC_PKG_VERSION}.apk" && \
	curl -Lo glibc-i18n-${GLIBC_PKG_VERSION}.apk "https://github.com/${GLIBC_GITHUB_USER}/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/glibc-i18n-${GLIBC_PKG_VERSION}.apk" && \
	apk add glibc-${GLIBC_PKG_VERSION}.apk glibc-bin-${GLIBC_PKG_VERSION}.apk glibc-i18n-${GLIBC_PKG_VERSION}.apk && \
	/usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
	ldconfig /lib /usr/glibc/usr/lib && \
	echo "servers pool.ntp.org" > /etc/ntpd.conf && \
	cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
	echo "Europe/Zurich" >  /etc/timezone && \
	apk del curl ca-certificates && \
	rm -rf /tmp/* /var/cache/apk/* && \
	echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

WORKDIR /

CMD ["/bin/bash"]
