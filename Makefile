COMPILER = clang++
GCCOPTIONS = -std=c++17 -Wall --pedantic-errors
TARGET = program


$(TARGET): $(wildcard *.cpp)
	$(COMPILER) $(GCCOPTIONS) -o $@ $^

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf ./$(TARGET)

.PHONY:
	run clean
