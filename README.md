# Bug repro in micronaut-openapi packages

The generated openapi docs don't respect the `mapping.path` attribute
properly for swagger-ui, redoc, or rapidoc.

Versions:
- java: 21
- micronaut: 4.3.4
- micronaut-openapi: 6.6.3

# Steps
To run the application first build it using `make build-mvn` then run
the program using `make run`. This starts the server on `localhost:10210`.

## Expected behaviour
When launching the application and navigating to
`localhost:10210/api-docs/<rapidoc OR redoc OR swagger-ui>`
the documentation loads as expected.

## Observed behaviour
When launching the application and navigating to
`localhost:10210/api-docs/<rapidoc OR redoc OR swagger-ui>` the sites
don't load. Opening the console I can observe that the javascript scripts
fail to load with a 404 not found error for all urls mentioned previously.

## Issue
It seems that the generated statics assets
(i.e. `target/classes/META-INF/swagger/views/redoc/index.html`) are missing
the `mapping.path` in the script tag `src` paths which loads the javascript
bundles. For example for redoc the generated html script tag is:
```html
<script src='/redoc/res/redoc.standalone.js'></script>
```
but it should be
```html
<script src='/api-docs/redoc/res/redoc.standalone.js'></script>
```
as this projects sets `mapping.path=api-docs` in the `openapi.properties` file.
Manually changing this in the generated file and rerunning the application
in IntelliJ fixes the issue (this won't work when run through maven as it
uses a precompiled jar).
