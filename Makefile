help:
	@echo 'Available commands:'
	@echo '    make package		create a tar achive for each components.'
	@echo '    make clean		clean the directory tree.'
	@echo

package:
	@mkdir -p dist
	@make -C ping package
	@cp ping/dist/* dist
	@make -C proxy package
	@cp proxy/dist/* dist
	@make -C pong package
	@cp pong/dist/* dist

clean:
	@make -C ping clean
	@make -C proxy clean
	@make -C pong clean
	@rm -frv dist
