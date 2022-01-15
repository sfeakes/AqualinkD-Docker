FROM gcc:4.9
#COPY . /usr/src/aqualinkd
#WORKDIR /usr/src/aqualinkd/AqualinkD
#RUN gcc -o myapp aqualinkd.c

VOLUME ["/aqualinkd"]
WORKDIR /usr/bin

#COPY . .
RUN git clone https://github.com/sfeakes/AqualinkD.git
WORKDIR ./AqualinkD
RUN make
#RUN make install

WORKDIR ./release
CMD ["sh", "-c", "/usr/bin/AqualinkD/release/aqualinkd -d -c ${config}"]
#CMD ["/usr/local/bin/aqualinkd"]
