# Antora S2I builder image  

The S2I [Antora](https://antora.org/ "Antora") builder can be used to use generate Antora S2I builds

# Usage

## Build image

```
git clone https://github.com/leathersole/antora-s2i.git
cd antora-s2i
docker build -t antora-s2i .
```

## Generate static site

```
s2i build <site url> antora-s2i <image name>
```
e.g.
```
s2i build https://gitlab.com/antora/demo/demo-site antora-s2i demo-site
```

## Start site
```
docker run -p 8080:8080 demo-site
```
