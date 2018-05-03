VERSION=1.0.0

PING_FILES=$(shell find ping -mindepth 1 -maxdepth 1 | grep -vE "node_modules")
PROXY_FILES=$(shell find proxy -mindepth 1 -maxdepth 1 | grep -vE "bin")
PONG_FILES=$(shell find pong -mindepth 1 -maxdepth 1 | grep -vE "venv")

PING_NAME=dist/ping-${VERSION}.tar
PROXY_NAME=dist/proxy-${VERSION}.tar
PONG_NAME=dist/pong-${VERSION}.tar

help:
	@echo 'Available commands:'
	@echo '    make package		create a tar achive for each components.'
	@echo '    make clean		clean the directory tree.'
	@echo

package: dist ${PING_NAME} ${PROXY_NAME} ${PONG_NAME}
	@echo 'All done!'

clean:
	@rm -fr dist
	@echo 'All clean!'



dist:
	mkdir -p dist

${PING_NAME}: ${PING_FILES}
	@echo 'Package ping..'
	@mkdir -p .tmp/ping
	@cp -R ${PING_FILES} .tmp/ping
	@cd .tmp && tar -vcf ../${PING_NAME} ping
	@rm -fr .tmp

${PROXY_NAME}: ${PROXY_FILES}
	@echo 'Package proxy..'
	@mkdir -p .tmp/proxy
	@cp -R ${PROXY_FILES} .tmp/proxy
	@cd .tmp && tar -vcf ../${PROXY_NAME} proxy
	@rm -fr .tmp

${PONG_NAME}: ${PONG_FILES}
	@echo 'Package pong..'
	@mkdir -p .tmp/pong
	@cp -R ${PONG_FILES} .tmp/pong
	@cd .tmp && tar -vcf ../${PONG_NAME} pong
	@rm -fr .tmp
