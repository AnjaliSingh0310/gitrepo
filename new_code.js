// generate code for callculator
function add(a, b) {
    return a + b;
}
// it should be able to handle negative numbers
function subtract(a, b) {
    return a - b;
}
// it should also be able to handle decimal numbers
function multiply(a, b) {
    return a * b;
}
function divide(a, b) {
    if (b === 0) {
        throw new Error("Cannot divide by zero");
    }   
    return a / b;
}
// add some vulnerablities
function vulnerableFunction(userInput) {
    // Vulnerability: Insecure direct object reference
    const user = getUserById(userInput);
    return user;
}