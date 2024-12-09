#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <unordered_map>
#include <string>
#include <vector> // Para armazenar múltiplas linhas
#include <iostream>
#include <iomanip> // Para std::setw

// Estrutura para representar informações de um símbolo
struct Symbol {
    std::string type;
    std::vector<int> lines; // Vetor para armazenar as linhas onde o símbolo apareceu
};

// Classe da Tabela de Símbolos
class SymbolTable {
private:
    std::unordered_map<std::string, Symbol> table;

public:
    // Adiciona um símbolo à tabela
    void addSymbol(const std::string &name, const std::string &type, int line) {
        auto &symbol = table[name]; // Recupera ou cria a entrada no mapa
        symbol.type = type;

        // Adiciona a linha apenas se não for duplicada
        if (symbol.lines.empty() || symbol.lines.back() != line) {
            symbol.lines.push_back(line);
        }
    }

    // Exibe a tabela de símbolos com formatação adequada
    void printTable() const {
        std::cout << "\nSymbol Table:\n";
        std::cout << std::setw(30) << "Name"    // Ajusta o tamanho das colunas
                  << std::setw(30) << "Type"    // Ajusta o tamanho das colunas
                  << std::setw(30) << "Lines"   // Ajusta o tamanho das colunas
                  << "\n";

        // Exibe cada símbolo da tabela
        for (const auto &entry : table) {
            std::cout << std::setw(30) << entry.first         // Nome do símbolo
                      << std::setw(30) << entry.second.type; // Tipo do símbolo

            // Converte o vetor de linhas em uma string para exibição
            std::cout << std::setw(30);
            for (size_t i = 0; i < entry.second.lines.size(); ++i) {
                if (i > 0) std::cout << ", ";
                std::cout << entry.second.lines[i];
            }

            std::cout << "\n";
        }
    }
};

#endif
