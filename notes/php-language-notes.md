---
#layout: default
layout: page
title: "PHP: personal notes"
tagline: "Some personal collected notes about programming in PHP."
category : notes
tags : [draft]
published: true
---

* __<https://www.phptherightway.com/>__

## Packages and stuff of general interest

* [symfony/property-access](https://packagist.org/packages/symfony/property-access)
  [doc](https://symfony.com/doc/current/components/property_access.html)
* <https://fractal.thephpleague.com/> __todo__
* <https://packagist.org/packages/arrilot/laravel-widgets> __check this__
* <https://github.com/vlucas/valitron> Standalone _single-php-file_ validation library.
* <https://github.com/exakat/php-static-analysis-tools> collection of links to
  static analysis tools for php codebases.

[cocur/slugify](https://packagist.org/packages/cocur/slugify) vs Laravel's `str_slug()`

* testing video courses (paid) : <https://course.testdrivenlaravel.com/>
    [tweet](https://twitter.com/MaurizioLepora/status/1024664162004332549)

* [Symfony's Serializer component](http://symfony.com/doc/master/components/serializer.html)
    ([annoucement](https://symfony.com/blog/new-in-symfony-2-7-serializer-component-improvements#new-objectnormalizer "New in Symfony 2.7: Serializer Component Improvements (2015)")
* [about the PropertyAccess component 84% optimization in 2016](https://dunglas.fr/2015/12/making-the-symfony-propertyaccess-component-50-faster-in-2-8-and-counting/)
* <https://github.com/postlight/awesome-cms#php>

## Composer, packages

* <https://getcomposer.org/doc/04-schema.md#repositories>
  * <https://getcomposer.org/doc/05-repositories.md#path>
* <https://getcomposer.org/doc/05-repositories.md>
* <https://jenssegers.com/83/list-outdated-composer-packages>
* [2017: Developing composer packages locally, johannespichler.com](https://johannespichler.com/developing-composer-packages-locally/)
* [2017: How To Make a PHP Package (Mahmoud Zalt, Medium)](https://medium.com/@Mahmoud_Zalt/how-to-make-a-php-package-5d3bb6b00df0)
  > Now I will share some standards I consider while developing new package, that you should consider too:
  > - Use __Semantic versioning__. And try not to introduce
  >   __backwards compatibility (BC) breaks__.
  > - Write __unit tests__. Aim for at least 60% __coverage__ in the first version.
  > - Try not introduce __dependencies__ on other packages.
  > - Conform to PSR-1 and PSR-2 as the coding style guide. (to apply the conventions on an existing package install PHP Code Sniffer.)
  > - Conform to __PSR-4 for autoloading__.
  > - DocBlock your code.
  > - Have an extensive README. And keep it updated.
  > - Default to the use of the Solar vocabulary for method names.
  > - Keep ‘Public’ functions names short (maximum of two words).
  > - Compose functionality through dependency injection, rather than through inheritance and base classes.
  > - Try to limit the levels of indentation per function (one per function is great).
  > - Use Continuous Integration tools, to automatically check coding standards and run tests.
  > - Prefer explicit configuration over implicit convention.
  > - Exclude non-essential files in .gitattributes.
  > - It’s always better to have a ‘Changelog’.
  > - Do never ever have duplicated code.
  > __Mahmoud Zalt__

## About PDFs

* Embed PDfs libraries & howtos:
    - <https://www.codexworld.com/embed-pdf-document-file-in-html-web-page/>
    - etc...

## Laravel

* __DI:__
    - [Gist/notes: Laravel's Dependency Injection Container in Depth (by davejamesmiller)](https://gist.github.com/davejamesmiller/bd857d9b0ac895df7604dd2e63b23afe)

* Testing:
    - <https://github.com/orangehill/iseed> “inverse seed generator” thing: saves
    your database changes as seeds or sthg like that.

## Symfony

* [symfony-collection js package](https://www.npmjs.com/package/symfony-collection)
* [Gist/notes: Symfony2 : How to easily implement a REST API with oAuth2 (for normal guys)](https://gist.github.com/lologhi/7b6e475a2c03df48bcdd)
* [api-platform.com](https://api-platform.com/) Symfon6 4, GraphQL, etc...

# Other

* [bshaffer.github.io : OAuth 2.0 server php](https://bshaffer.github.io/oauth2-server-php-docs/)
* [Asana on “what is oauth”](https://asana.com/developers/documentation/getting-started/auth#api-key)
* About proxies: <http://ocramius.github.io/presentations/proxy-pattern-in-php/>

    ```php
    require_once 'vendor/autoload.php';
    use ProxyManager\Factory\LazyLoadingValueHolderFactory;

    $factory = new LazyLoadingValueHolderFactory();

    $proxy = $factory->createProxy(
        'My\Slow\Foo',
        function (& $wrappedObject, $proxy) {
            $wrappedObject = new My\Slow\Object();

            $proxy->setProxyInitializer(null);
        }
    );

    $proxy->doFoo();
    ```

    Or you can just resort to `__call()` magic :

    ```php
    class test {
        function __construct(){}

        private function test1(){
            echo "In test1", PHP_EOL;
        }

        public function __call($method,$arguments)
        {
            if(method_exists($this, $method)) {
                $this->test1();
                return call_user_func_array(array($this,$method),$arguments);
            }
        }
    }
    ```

* Generate random hash string [SO](https://stackoverflow.com/a/31419246/643087):

    ```php
    echo bin2hex(random_bytes($length));
    echo bin2hex(openssl_random_pseudo_bytes(16));
    echo bin2hex(mcrypt_create_iv(128, MCRYPT_DEV_RANDOM));
    echo md5(uniqid(mt_rand(), true)); // not considered safe.
    echo str_shuffle('ASGDHFfdgfdre5475433fd');
    ```

## Misc.

* <https://medium.com/@davidtstrauss/avoiding-the-pitfalls-of-apcu-4aa9de00ef93>

    About APCu; must read.

__EOF__
