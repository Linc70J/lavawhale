# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: publish

publish:
	cp -r publish/ ../
	vim ../build/.env.dev