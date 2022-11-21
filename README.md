# Image to check files by Drupal Code Sniffer

This image is based on the official [Drupal Docker image](https://hub.docker.com/_/drupal/). It adds the [Drupal Code Sniffer](https://www.drupal.org/project/coder) to the image.

## Usage dev

create test.php file with the following content:

```php
<?php
class Test {
    public function __construct() {
        echo 'Test';
    }

    function test_fail() {}
    function testPass() {}
}
```

Run in terminal

```sh
docker build -t sniffer .
docker run --rm -v $(pwd):/app sniffer test.php
```
