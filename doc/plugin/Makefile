default: clean build 


SOURCE = main.md YCM.md
OBJS = README.md

build: 
	pandoc ${SOURCE} -o ${OBJS}

clean:
	${RM} ${OBJS}

