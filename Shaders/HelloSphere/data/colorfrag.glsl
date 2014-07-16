#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec4 vNormal;

void main() {
  /*
  So the reason the dot product works is that given two vectors it comes out
  with a number that tells you how “similar” the two vectors are. With normalised vectors,
  if they point in exactly the same direction, you get a value of 1. If they point in
  opposite directions you get a -1. What we do is take that number and apply it to our
  lighting. So a vertex in the top right will have a value near or equal to 1, i.e. fully
  lit, whereas a vertex on the side would have a value near 0 and round the back would be -1.
  We clamp the value to 0 for anything negative, but when you plug the numbers in you end up
  with the basic lighting we’re seeing.

  http://aerotwist.com/tutorials/an-introduction-to-shaders-part-2/
  */

  // calc the dot product and clamp
  // 0 -> 1 rather than -1 -> 1
  // vec3 light = vec3(0.5, 0.2, 1.0);
  vec4 light = vec4(-1.0, 0.0, 1.0, 1.0);

  // ensure it's normalized
  light = normalize(light);

  // calculate the dot product of
  // the light to the vertex normal
  float dProd = max(0.0,
                    dot(vNormal, light));

  // float dProd = dot(vNormal, light);

  // feed into our frag colour
  gl_FragColor = vec4(0.0, // R
                      0.0, // G
                      dProd, // B
                      1.0);  // A
  

  // Passes set color through
  // gl_FragColor = vertColor;

  // Turns set color to inverse and half transparency
  // gl_FragColor = vec4(vec3(1) - vertColor.xyz, 0.5);
}