SUBDIRS = plugin 
SOURCE = main.md */README.md TODO.md */TODO.md shortcuts.md
OBJS = README.md

.PHONY: all  

all: ${OBJS}
	pandoc ${SOURCE} -o ${OBJS}
	cp ${OBJS} ../${OBJS}

${OBJS}: sub

sub:  
	@list='$(SUBDIRS)';\
		for subdir in $$list; \
		do echo "cd in $$subdir"; \
		$(MAKE) -C $$subdir ; \
		done  


.PHONY: clean  
clean:  
	@list='$(SUBDIRS)';\
		for subdir in $$list; \
		do echo "Clean in $$subdir"; \
		$(MAKE) -C $$subdir clean; \
		done  
	${RM} ${OBJS}

