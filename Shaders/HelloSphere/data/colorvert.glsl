#define PROCESSING_COLOR_SHADER

uniform mat4 transform;

attribute vec4 position;
attribute vec4 color;
attribute vec4 normal;
attribute float displacement;

varying vec4 vertColor;
varying vec4 vNormal;

void main() {
  vNormal = normal;

  // push the displacement into the
  // three slots of a 3D vector so
  // it can be used in operations
  // with other 3D vectors like
  // positions and normals
  vec4 newPosition = position + normal * vec4(displacement);

  gl_Position = transform * position;    
  vertColor = color;
}