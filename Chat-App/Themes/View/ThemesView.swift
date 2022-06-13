//
//  ThemesView.swift
//  Chat-App
//
//  Created by Станислав on 12.06.2022.
//

import UIKit

protocol ThemesViewDelegate: AnyObject {
    func themeViewTapped()
}

class ThemesView: UIView {
    // MARK: - Visual Components
    lazy var classicThemeView: UIView = {
        let theme = ClassicTheme()
        let view = createThemeView(
            outgoingMessageColor: theme.outgoingMessageColor,
            incomingMessageColor: theme.incomingMessageColor,
            backgroundColor: theme.backgroundColor
        )
                
        return view
    }()
    
    lazy var dayThemeView: UIView = {
        let theme = DayTheme()
        let view = createThemeView(
            outgoingMessageColor: theme.outgoingMessageColor,
            incomingMessageColor: theme.incomingMessageColor,
            backgroundColor: theme.backgroundColor
        )
                
        return view
    }()
    
    lazy var nightThemeView: UIView = {
        let theme = NightTheme()
        let view = createThemeView(
            outgoingMessageColor: theme.outgoingMessageColor,
            incomingMessageColor: theme.incomingMessageColor,
            backgroundColor: theme.backgroundColor
        )
                
        return view
    }()
    
    lazy var classicLabel: UILabel = {
        let label = UILabel()
        
        label.isUserInteractionEnabled = true
        label.text = "Classic"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        
        label.isUserInteractionEnabled = true
        label.text = "Day"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nightLabel: UILabel = {
        let label = UILabel()
        
        label.isUserInteractionEnabled = true
        label.text = "Night"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Public Properties
    weak var delegate: ThemesViewDelegate!
    
    // MARK: - Private Properties
    var currentThemeView: UIView?
    let themeService = ThemeService()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupActions()
        setupConstraints()
        setCurrentBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Target Actions
extension ThemesView {
    @objc private func classicViewTapped() {
        setViewBorder(classicThemeView)
        themeService.saveTheme(Theme.classic)
        delegate.themeViewTapped()
    }
    
    @objc private func dayViewTapped() {
        setViewBorder(dayThemeView)
        themeService.saveTheme(Theme.day)
        delegate.themeViewTapped()
    }
    
    @objc private func nightViewTapped() {
        setViewBorder(nightThemeView)
        themeService.saveTheme(Theme.night)
        delegate.themeViewTapped()
    }
}

// MARK: - Private Methods
extension ThemesView {
    private func setViewBorder(_ view: UIView) {
        currentThemeView?.isBorderVisible = false
        currentThemeView = view
        view.isBorderVisible = true
    }
    
    private func setCurrentBorder() {
        let theme = themeService.getCurrentTheme()
        
        switch theme {
        case .day: setViewBorder(dayThemeView)
        case .night: setViewBorder(nightThemeView)
        default: setViewBorder(classicThemeView)
        }
    }
    
    private func addSubviews() {
        addSubview(classicThemeView)
        addSubview(classicLabel)
        addSubview(dayThemeView)
        addSubview(dayLabel)
        addSubview(nightThemeView)
        addSubview(nightLabel)
    }
    
    private func setupActions() {
        classicThemeView.addGestureRecognizer(getGestureRecognizer(with: #selector(classicViewTapped)))
        classicLabel.addGestureRecognizer(getGestureRecognizer(with: #selector(classicViewTapped)))
        
        dayThemeView.addGestureRecognizer(getGestureRecognizer(with: #selector(dayViewTapped)))
        dayLabel.addGestureRecognizer(getGestureRecognizer(with: #selector(dayViewTapped)))
        
        nightThemeView.addGestureRecognizer(getGestureRecognizer(with: #selector(nightViewTapped)))
        nightLabel.addGestureRecognizer(getGestureRecognizer(with: #selector(nightViewTapped)))
    }
    
    private func getGestureRecognizer(with selector: Selector) -> UITapGestureRecognizer {
        UITapGestureRecognizer(target: self, action: selector)
    }
    
    private func createThemeView(outgoingMessageColor: UIColor, incomingMessageColor: UIColor, backgroundColor: UIColor) -> UIView {
        let backgroundView: UIView = {
            let view = UIView()
            
            view.backgroundColor = backgroundColor
            view.layer.cornerRadius = 10
            view.isUserInteractionEnabled = true
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        let outgoingMessageView: UIView = {
            let view = UIView()
            
            view.backgroundColor = outgoingMessageColor
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        let incomingMessageView: UIView = {
            let view = UIView()
            
            view.backgroundColor = incomingMessageColor
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        backgroundView.addSubview(incomingMessageView)
        backgroundView.addSubview(outgoingMessageView)
        
        NSLayoutConstraint.activate([
            incomingMessageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -25),
            incomingMessageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            incomingMessageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            incomingMessageView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.41),
            
            outgoingMessageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10),
            outgoingMessageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            outgoingMessageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25),
            outgoingMessageView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.41)
        ])
        
        return backgroundView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            classicThemeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            classicThemeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            classicThemeView.heightAnchor.constraint(equalToConstant: 60),
            classicThemeView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120),
            
            classicLabel.topAnchor.constraint(equalTo: classicThemeView.bottomAnchor, constant: 10),
            classicLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dayThemeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dayThemeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dayThemeView.heightAnchor.constraint(equalToConstant: 60),
            dayThemeView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: dayThemeView.bottomAnchor, constant: 10),
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nightThemeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            nightThemeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nightThemeView.heightAnchor.constraint(equalToConstant: 60),
            nightThemeView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 120),
            
            nightLabel.topAnchor.constraint(equalTo: nightThemeView.bottomAnchor, constant: 10),
            nightLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
