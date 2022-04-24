.PHONY: all publish publish_no_init

all: graph republish rsync

graph: publish.el
	@echo "Graphing..."
	emacs --batch --load publish.el --funcall commonplace/build-graph-json
	@chmod 755 graph.svg

publish: publish.el
	@echo "Publishing..."
	emacs --batch --load publish.el --funcall commonplace/publish

republish: publish.el
	@echo "Republishing all files..."
	emacs --batch --load publish.el --funcall commonplace/republish

rsync:
	@echo "rsyncing published site to hosting..."
	rsync -chavz /var/www/html/commonplace/ node5:/var/www/org-zh

publish_no_init: publish.el
	@echo "Publishing... with --no-init."
	emacs --batch --no-init --load publish.el --funcall org-publish-all

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf public_html
	@rm -rvf ~/.org-timestamps/*
