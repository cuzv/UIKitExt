public struct SectionModel<Section: Hashable, Element: Hashable> {
    public var model: Section
    public var elements: [Element]

    public init(model: Section, elements: [Element]) {
        self.model = model
        self.elements = elements
    }
}

extension SectionModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(model)
    }

    public static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        lhs.model == rhs.model
    }
}
