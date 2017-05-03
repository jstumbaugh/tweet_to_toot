all: rm build run ps

rm:
	-docker rm tweet_to_toot_image
	-rm .saved_tweets
build:
	docker build -t "tweet_to_toot" .
run:
	docker run -it -d --name tweet_to_toot_image tweet_to_toot
stop:
	docker stop tweet_to_toot_image
start:
	docker start tweet_to_toot_image
ps:
	docker ps -a
logs:
	docker logs tweet_to_toot_image
ssh:
	docker exec -i -t tweet_to_toot_image /bin/bash
