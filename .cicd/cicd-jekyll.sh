#############################################################################
# Docker Compose [Development]
#############################################################################
# start up
docker-compose -f .cicd/jekyll/docker-compose.Development.yaml up

# browse
start http://localhost:4000

# take down
docker-compose -f .cicd/jekyll/docker-compose.Development.yaml down



#############################################################################
# Docker Compose [Production]
#############################################################################
# start up
docker-compose -f .cicd/jekyll/docker-compose.Production.yaml up

# take down
docker-compose -f .cicd/jekyll/docker-compose.Production.yaml down