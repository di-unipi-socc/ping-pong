NAME=ping
FILES=$(shell ls ./ | grep -vE "dist|node_modules")

help:
	@echo 'Available commands:'
	@echo '    make package		build package.'
	@echo '    make clean		clean the directory tree.'
	@echo

package:
	@echo 'build archive..'
	@mkdir -p .tmp/${NAME}
	@mkdir -p dist
	@cp -R ${FILES} .tmp/${NAME}
	@cd .tmp && tar -vcf ../dist/${NAME}.tar ${NAME}
	@rm -fr .tmp
	@echo 'done.'

clean:
	@rm -frv dist
