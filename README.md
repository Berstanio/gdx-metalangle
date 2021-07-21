# gdx-metalangle
This provides MetalANGLE support for libgdx ios backends. 
## Installation guide
```git clone https://github.com/Berstanio/gdx-metalangle.git```  
```cd gdx-metalangle```  
```mvn [clean] install```  
To include it into your project use  
```com.badlogicgames.gdx:gdx-platform:1.10.1-SNAPSHOT:natives-ios-metalangle``` as dependency instead of ```com.badlogicgames.gdx:gdx-platform:1.10.1-SNAPSHOT:natives-ios```.

## Current problems
* The size of the static MetalANGLE lib is enormous.
* Git version >= 2.25 is needed.
* [GLKit needs to be replaced.](https://github.com/kakashidinho/metalangle/issues/65)
