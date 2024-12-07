#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <unordered_map>
#include <string>
#include <iostream>
#include <iomanip> // Para std::setw

// Estrutura para representar informações de um símbolo
struct Symbol {
    std::string type;
    int line; // Linha em que o símbolo foi encontrado
};

// Classe da Tabela de Símbolos
class SymbolTable {
private:
    std::unordered_map<std::string, Symbol> table;

public:
    // Adiciona um símbolo à tabela
    void addSymbol(const std::string &name, const std::string &type, int line) {
        if (table.find(name) == table.end()) {
            table[name] = {type, line};
        }
    }

    // Exibe a tabela de símbolos com formatação adequada
    void printTable() const {
        std::cout << "Symbol Table:\n";
        std::cout << std::setw(30) << "Name"    // Ajusta o tamanho das colunas
                  << std::setw(30) << "Type"    // Ajusta o tamanho das colunas
                  << std::setw(30) << "Line"    // Ajusta o tamanho das colunas
                  << "\n";

        // Exibe cada símbolo da tabela
        for (const auto &entry : table) {
            std::cout << std::setw(30) << entry.first    // Nome do símbolo
                      << std::setw(30) << entry.second.type // Tipo do símbolo
                      << std::setw(30) << entry.second.line // Linha do símbolo
                      << "\n";
        }
    }
};

#endif
