import 'dart:math';

bool canGoLeft(List<List<int>> matrix) {
  var size = matrix.length;
  for (int i = 0; i < size; i++) {
    for (int j = 0; i < size - 1; j++) {
      if (matrix[i][j] > 0 && matrix[i][j] == matrix[i][j + 1]) {
        return true;
      }
      if (matrix[i][j] == 0 && matrix[i][j + 1] > 0) {
        return true;
      }
    }
  }
  return false;
}

bool canGoRight(List<List<int>> matrix) {
  var size = matrix.length;
  for (int i = 0; i < size; i++) {
    for (int j = 0; i < size - 1; j++) {
      if (matrix[i][j] > 0 && matrix[i][j] == matrix[i][j + 1]) {
        return true;
      }
      if (matrix[i][j] > 0 && matrix[i][j + 1] == 0) {
        return true;
      }
    }
  }
  return false;
}

bool canGoDown(List<List<int>> matrix) {
  var size = matrix.length;
  for (var i = 0; i < size; i++) {
    for (var j = 0; j < size - 1; j++) {
      if (matrix[j][i] > 0 && matrix[j][i] == matrix[j + 1][i]) {
        return true;
      }
      if (matrix[j][i] > 0 && matrix[j + 1][i] == 0) {
        return true;
      }
    }
  }
  return false;
}

bool canGoUp(List<List<int>> matrix) {
  var size = matrix.length;
  for (var i = 0; i < size; i++) {
    for (var j = 0; j < size - 1; j++) {
      if (matrix[j][i] > 0 && matrix[j][i] == matrix[j + 1][i]) {
        return true;
      }
      if (matrix[j][i] == 0 && matrix[j + 1][i] > 0) {
        return true;
      }
    }
  }
  return false;
}

List<Cell> getFilledItems(List<List<int>> matrix) {
  var size = matrix.length;
  var filled = new List<Cell>();
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (matrix[i][j] > 0) {
        filled.add(new Cell(i, j, matrix[i][j]));
      }
    }
  }
  return filled;
}

List<List<int>> move(List<List<int>> matrix, int d) {
  var filled = getFilledItems(matrix);
  var size = matrix.length;
  switch (d) {
    case 0: // up
      for (var i = 0; i < size; i++) {
        var line = List<Cell>();
        for (var j = 0; j < filled.length; j++) {
          if (filled[j].y == i) {
            line.add(filled[j]);
          }
        }
        var lineLength = line.length;
        for (var j = 0; j < lineLength; j++) {
          matrix[line[j].x][line[j].y] = 0;
          matrix[j][i] = line[j].value;
        }
      }
      break;
    case 1: //down
      for (var i = 0; i < size; i++) {
        var line = List<Cell>();
        for (var j = 0; j < filled.length; j++) {
          if (filled[j].y == i) {
            line.add(filled[j]);
          }
        }
        var lineLength = line.length;
        for (var j = 0; j < lineLength; j++) {
          matrix[line[lineLength - j - 1].x][line[lineLength - j - 1].y] = 0;
          matrix[size - j - 1][i] = line[lineLength - j - 1].value;
        }
      }
      break;
    case 2: // left
      for (var i = 0; i < size; i++) {
        var line = List<Cell>();
        for (var j = 0; j < filled.length; j++) {
          if (filled[j].x == i) {
            line.add(filled[j]);
          }
        }
        var lineLength = line.length;
        for (var j = 0; j < lineLength; j++) {
          matrix[line[j].x][line[j].y] = 0;
          matrix[i][j] = line[j].value;
        }
      }
      break;
    case 3:
      for (var i = 0; i < size; i++) {
        var line = List<Cell>();
        for (var j = 0; j < filled.length; j++) {
          if (filled[j].x == i) {
            line.add(filled[j]);
          }
        }
        print(line);
        var lineLength = line.length;
        for (var j = 0; j < lineLength; j++) {
          matrix[line[lineLength - j - 1].x][line[lineLength - j - 1].y] = 0;
          matrix[i][size - j - 1] = line[lineLength - j - 1].value;
        }
      }
      break;
  }
  return matrix;
}

List<List<int>> merge(List<List<int>> matrix, int d) {
  var size = matrix.length;
  switch (d) {
    case 0:
      for (var i = 0; i < size; i++) {
        for (var j = 0; j < size - 1; j++) {
          if (matrix[j][i] > 0 && matrix[j][i] == matrix[j + 1][i]) {
            matrix[j][i] *= 2;
            matrix[j + 1][i] = 0;
          }
        }
      }
      break;
    case 1:
      for (var i = 0; i < size; i++) {
        for (var j = size - 1; j > 0; j--) {
          if (matrix[j][i] > 0 && matrix[j][i] == matrix[j - 1][i]) {
            matrix[j][i] *= 2;
            matrix[j - 1][i] = 0;
          }
        }
      }
      break;
    case 2:
      for (var i = 0; i < size; i++) {
        for (var j = 0; j < size - 1; j++) {
          if (matrix[i][j] > 0 && matrix[i][j] == matrix[i][j + 1]) {
            matrix[i][j] *= 2;
            matrix[i][j + 1] = 0;
          }
        }
      }
      break;
    case 3:
      for (var i = 0; i < size; i++) {
        for (var j = size - 1; j > 0; j--) {
          if (matrix[i][j] > 0 && matrix[i][j] == matrix[i][j - 1]) {
            matrix[i][j] *= 2;
            matrix[i][j - 1] = 0;
          }
        }
      }
      break;
  }
  return matrix;
}

List<List<int>> go(List<List<int>> matrix, int d) {
  var newmatrix = move(matrix, d);
  newmatrix = merge(newmatrix, d);
  newmatrix = move(newmatrix, d);
  print(newmatrix);
  return newmatrix;
}

List<List<int>> addNumber(List<List<int>> matrix, List<List<int>> matrixNew) {
  List<Point> options = [];
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (matrix[i][j] == 0) {
        options.add(Point(i, j));
      }
    }
  }
  if (options.length > 0) {
    int spotRandomIndex = new Random().nextInt(options.length);
    Point spot = options[spotRandomIndex];
    int r = new Random().nextInt(100);
    matrix[spot.x][spot.y] = r > 50 ? 4 : 2;
    matrixNew[spot.x][spot.y] = 1;
  }
  return matrix;
}

List<List<int>> blankMatrix() {
  List<List<int>> rows = [];
  for (int i = 0; i < 4; i++) {
    rows.add([0, 0, 0, 0]);
  }
  return rows;
}

class Cell {
  int x;
  int y;
  int value;
  Cell(int x, int y, int value) {
    this.x = x;
    this.y = y;
    this.value = value;
  }
}

class Point {
  int x;
  int y;

  Point(this.x, this.y);
}
