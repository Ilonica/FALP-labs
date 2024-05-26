import java.io.File

// Задание 1
// Функция с телом выражения max(X,Y,Z), находящая максимальное из чисел X, Y и Z.
fun max(x: Int, y: Int, z: Int): Int = if (x > y) if (x > z) x else z else if (y > z) y else z
// Функция факториала fact(N), с помощью рекурсии вверх.
fun factup(n: Int): Int = if (n <= 1) 1 else factup(n - 1) * n
// Функция факториала fact(N), с помощью рекурсии вниз.
tailrec fun factd(n: Int, a: Int): Int = if (n <= 1) n * a else factd(n - 1, n * a)
fun factdown(n: Int): Int = factd(n, 1)
// Сумма цифр числа с помощью рекурсии вверх.
fun sumc(n: Int): Int = if (n <= 10) n else (n % 10) + (sumc(n / 10))
// Сумма цифр числа с помощью рекурсии вниз.
fun sumcda(n: Int, a: Int): Int = if (n < 10) n + a else sumcda(n / 10, a + (n % 10))
fun sumcd(n: Int): Int = sumcda(n, 0)
// Функция, которая принимает один аргумент и возвращает функцию. Если аргумент истинный, то функция возвращает функцию, считающую сумму
// цифр числа, если ложный, возвращает функцию, считающую факториал числа.
fun calculate(f: Boolean): (Int) -> Int = if (f) ::sumc else ::factup
// Функция для обход числа, которая выполняет операции на цифрами числа, принимает три аргумента, число, функция (сумма, произведение, минимум,
// максимум) и инициализирующее значение.
tailrec fun digits(n: Int, a: Int = 0, f: (Int, Int) -> Int): Int =
  if (n == 0) a else digits(n / 10, f(a, n % 10), f)
// Вызовы через лямбды
  fun sumd(n: Int): Int = digits(n, 0) { a, b -> (a + b) }
  fun muld(n: Int): Int = digits(n, 1) { a, b -> (a * b) }
  fun maxd(n: Int): Int = digits(n / 10, n % 10) { a, b -> if (a > b) a else b }
  fun mind(n: Int): Int = digits(n / 10, n % 10) { a, b -> if (a < b) a else b }

fun main() {
  println("Задание 1")
  println("Максимальное число из 28, 7, 15: ${max(28,7,15)}")
  println("Факториал 5 рекурсия вверх: ${factup(5)}")
  println("Факториал 5 рекурсия вниз: ${factdown(5)}")
  println("Сумма цифр 579 рекурсия вверх: ${sumc(579)}")
  println("Сумма цифр 579 рекурсия вниз: ${sumcd(1234)}")
  println("Если TRUE суммируем цифры числа 15: ${calculate(true)(15)}")
  println("Если FALSE находим факториал 15: ${calculate(false)(15)}")
  println("Сумма цифр 575: ${sumd(575)}")
  println("Произведение цифр 575: ${muld(575)}")
  println("Максимальная цифра 575: ${maxd(575)}")
  println("Минимальная цифра 575: ${mind(575)}\n")
}
        
