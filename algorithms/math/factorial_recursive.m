function result = factorial_recursive(n)
    if n == 0 || n == 1
        result = 1;
    else
        result = n * factorial_recursive(n - 1);
    end
end
