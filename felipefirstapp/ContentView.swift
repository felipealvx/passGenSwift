//
//  ContentView.swift
//  felipefirstapp
//
//  Created by iredefbmac_19 on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tamanhoSenha: Double = 12
    @State private var maiusculas: Bool = true
    @State private var minusculas: Bool = true
    @State private var numeros: Bool = true
    @State private var caracteresEspeciais: Bool = true
    @State private var senhaGerada: String = "Sua senha aparecerá aqui."
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Gerador de Senhas")
                .bold()
                .font(.largeTitle)
                .foregroundStyle(.tint)
            VStack {
                Text("Escolha o tamanho da senha que você quer gerar")
                    .italic()
                Text(" \(Int(tamanhoSenha)) ")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.tint)
                Slider(value: $tamanhoSenha, in: 6...12, step: 1)
            }
            
            
            Toggle("Incluir Maiusculas", isOn: $maiusculas)
            Toggle("Incluir Minusculas", isOn: $minusculas)
            Toggle("Incluir Numeros", isOn: $numeros)
            Toggle("Incluir Caracteres Especiais", isOn: $caracteresEspeciais)
            
            Button(action: {
                senhaGerada = gerarSenha(
                    tamanho: Int(tamanhoSenha),
                    maiusculas: maiusculas,
                    minusculas: minusculas,
                    numeros: numeros,
                    caracteresEspeciais: caracteresEspeciais
                )
            }) {
                Text("Gerar Senha")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color .blue)
                    .foregroundStyle( .white)
                    .bold()
                    .cornerRadius(5)
            }
            
            Text( senhaGerada )
                .font(.headline)
                .padding()
                .background(Color .gray.opacity(0.2))
                .cornerRadius(5)
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = senhaGerada
                    }) {
                        Text("Copiar Senha")
                        Image(systemName: "doc.on.doc")
                    }
                }
                
        }
        .padding()
    }
    
    func gerarSenha (tamanho: Int, maiusculas: Bool, minusculas: Bool, numeros: Bool, caracteresEspeciais: Bool) -> String {
        let letrasMaiusculas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let letrasMinusculas = "abcdefghijklmnopqrstuvwxyz"
        let numerosCaracteres = "1234567890"
        let especiais = "+*&¨%$#@!"
        var caracteres = ""
        
        if maiusculas { caracteres += letrasMaiusculas }
        if minusculas { caracteres += letrasMinusculas }
        if numeros { caracteres += numerosCaracteres }
        if caracteresEspeciais { caracteres += especiais }
        
        //estudar melhor o guard
        guard !caracteres.isEmpty else { return "Selecione pelo menos uma opção" }
        
        return String((0..<tamanho).compactMap { _ in caracteres.randomElement() })
    }
}

#Preview {
    ContentView()
}
