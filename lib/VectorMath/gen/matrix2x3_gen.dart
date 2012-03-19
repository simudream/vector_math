/*

  VectorMath.dart
  
  Copyright (C) 2012 John McCutchan <john@johnmccutchan.com>
  
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/
class mat2x3 {
  vec3 col0;
  vec3 col1;
  num get rows() => 3;
  num get cols() => 2;
  num get length() => 2;
  vec2 get row0() => getRow(0);
  vec2 get row1() => getRow(1);
  vec2 get row2() => getRow(2);
  set row0(vec2 arg) => setRow(0, arg);
  set row1(vec2 arg) => setRow(1, arg);
  set row2(vec2 arg) => setRow(2, arg);
  vec3 operator[](int column) {
    assert(column >= 0 && column < 2);
    switch (column) {
      case 0: return col0; break;
      case 1: return col1; break;
    }
    throw new IllegalArgumentException(column);
  }
  vec3 operator[]=(int column, vec3 arg) {
    assert(column >= 0 && column < 2);
    switch (column) {
      case 0: col0 = arg; return col0; break;
      case 1: col1 = arg; return col1; break;
    }
    throw new IllegalArgumentException(column);
  }
  String toString() {
    String s = '';
    s += '[0] ${getRow(0)}\n';
    s += '[1] ${getRow(1)}\n';
    s += '[2] ${getRow(2)}\n';
    return s;
  }
  void setRow(int row, vec2 arg) {
    assert(row >= 0 && row < 3);
    this[0][row] = arg[0];
    this[1][row] = arg[1];
  }
  vec2 getRow(int row) {
    assert(row >= 0 && row < 3);
    vec2 r = new vec2();
    r[0] = this[0][row];
    r[1] = this[1][row];
    return r;
  }
  void setColumn(int column, vec3 arg) {
    assert(column >= 0 && column < 2);
    this[column] = arg;
  }
  vec3 getColumn(int column) {
    assert(column >= 0 && column < 2);
    return new vec3(this[column]);
  }
  Dynamic operator*(Dynamic arg) {
    if (arg is num) {
      mat2x3 r = new mat2x3();
      r[0][0] = this[0][0] * arg;
      r[0][1] = this[0][1] * arg;
      r[0][2] = this[0][2] * arg;
      r[1][0] = this[1][0] * arg;
      r[1][1] = this[1][1] * arg;
      r[1][2] = this[1][2] * arg;
      return r;
    }
    if (arg is vec2) {
      vec3 r = new vec3();
      r[0] = dot(row0, arg);
      r[1] = dot(row1, arg);
      r[2] = dot(row2, arg);
      return r;
    }
    if (3 == arg.cols) {
      Dynamic r = null;
      if (arg.rows == 2) {
        r = new mat2x2();
      }
      if (arg.rows == 3) {
        r = new mat2x3();
      }
      if (arg.rows == 4) {
        r = new mat2x4();
      }
      for (int j = 0; j < arg.rows; j++) {
        r[0][j] = dot(this.getRow(0), arg.getColumn(j));
      }
      for (int j = 0; j < arg.rows; j++) {
        r[1][j] = dot(this.getRow(1), arg.getColumn(j));
      }
      return r;
    }
    throw new IllegalArgumentException(arg);
  }
  mat2x3 operator+(mat2x3 arg) {
    mat2x3 r = new mat2x3();
    r[0][0] = this[0][0] + arg[0][0];
    r[0][1] = this[0][1] + arg[0][1];
    r[0][2] = this[0][2] + arg[0][2];
    r[1][0] = this[1][0] + arg[1][0];
    r[1][1] = this[1][1] + arg[1][1];
    r[1][2] = this[1][2] + arg[1][2];
    return r;
  }
  mat2x3 operator-(mat2x3 arg) {
    mat2x3 r = new mat2x3();
    r[0][0] = this[0][0] - arg[0][0];
    r[0][1] = this[0][1] - arg[0][1];
    r[0][2] = this[0][2] - arg[0][2];
    r[1][0] = this[1][0] - arg[1][0];
    r[1][1] = this[1][1] - arg[1][1];
    r[1][2] = this[1][2] - arg[1][2];
    return r;
  }
  mat2x3 operator negate() {
    mat2x3 r = new mat2x3();
    r[0] = -this[0];
    r[1] = -this[1];
    return r;
  }
  mat3x2 transposed() {
    mat3x2 r = new mat3x2();
    r[0][0] = this[0][0];
    r[1][0] = this[0][1];
    r[0][1] = this[1][0];
    r[1][1] = this[1][1];
    r[0][2] = this[2][0];
    r[1][2] = this[2][1];
    return r;
  }
  mat2x3 absolute() {
    mat2x3 r = new mat2x3();
    r[0][0] = this[0][0].abs();
    r[0][1] = this[0][1].abs();
    r[0][2] = this[0][2].abs();
    r[1][0] = this[1][0].abs();
    r[1][1] = this[1][1].abs();
    r[1][2] = this[1][2].abs();
    return r;
  }
  num infinityNorm() {
    num norm = 0.0;
    {
      num row_norm = 0.0;
      row_norm += this[0][0].abs();
      row_norm += this[0][1].abs();
      row_norm += this[0][2].abs();
      norm = row_norm > norm ? row_norm : norm;
    }
    {
      num row_norm = 0.0;
      row_norm += this[1][0].abs();
      row_norm += this[1][1].abs();
      row_norm += this[1][2].abs();
      norm = row_norm > norm ? row_norm : norm;
    }
    return norm;
  }
  num relativeError(mat2x3 correct) {
    num this_norm = infinityNorm();
    num correct_norm = correct.infinityNorm();
    num diff_norm = (this_norm - correct_norm).abs();
    return diff_norm/correct_norm;
  }
  num absoluteError(mat2x3 correct) {
    num this_norm = infinityNorm();
    num correct_norm = correct.infinityNorm();
    num diff_norm = (this_norm - correct_norm).abs();
    return diff_norm;
  }
  mat2x3([Dynamic arg0, Dynamic arg1, Dynamic arg2, Dynamic arg3, Dynamic arg4, Dynamic arg5]) {
    //Initialize the matrix as the identity matrix
    col0 = new vec3();
    col1 = new vec3();
    col0[0] = 1.0;
    col1[1] = 1.0;
    if (arg0 is num && arg1 is num && arg2 is num && arg3 is num && arg4 is num && arg5 is num) {
      col0[0] = arg0;
      col0[1] = arg1;
      col0[2] = arg2;
      col1[0] = arg2;
      col1[1] = arg3;
      col1[2] = arg4;
      return;
    }
    if (arg0 is num && arg1 == null && arg2 == null && arg3 == null && arg4 == null && arg5 == null) {
      col0[0] = arg0;
      col1[1] = arg0;
      return;
    }
    if (arg0 is vec2 && arg1 is vec2) {
      col0 = arg0;
      col1 = arg1;
      return;
    }
    if (arg0 is mat2x3) {
      col0 = arg0.col0;
      col1 = arg0.col1;
      return;
    }
    if (arg0 is mat2x2) {
      col0[0] = arg0.col0[0];
      col0[1] = arg0.col0[1];
      col1[0] = arg0.col1[0];
      col1[1] = arg0.col1[1];
      return;
    }
    if (arg0 is vec2 && arg1 == null && arg2 == null && arg3 == null && arg4 == null && arg5 == null) {
      col0[0] = arg0[0];
      col1[1] = arg0[1];
    }
  }
  mat2x3.outer(vec2 u, vec3 v) {
    col0[0] = u[0] * v[0];
    col0[1] = u[0] * v[1];
    col0[2] = u[0] * v[2];
    col1[0] = u[1] * v[0];
    col1[1] = u[1] * v[1];
    col1[2] = u[1] * v[2];
  }
  mat2x3.zero() {
    col0[0] = 0.0;
    col0[1] = 0.0;
    col0[2] = 0.0;
    col1[0] = 0.0;
    col1[1] = 0.0;
    col1[2] = 0.0;
  }
}