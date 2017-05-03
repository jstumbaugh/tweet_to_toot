all: rm build run ps

rm:
	docker rm tweet_to_toot_image
build:
	docker build -t "tweet_to_toot" .
run:
	docker run -it -d --name tweet_to_toot_image tweet_to_toot
ps:
	docker ps -a
logs:
	docker logs tweet_to_toot_image
