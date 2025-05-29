using ECheck.Core.Abstraction.Attributes;
using ECheck.Core.Logic.ModelEnrichmentCustom.Enums;
using ECheck.Core.Logic.ModelEnrichmentCustom.ModelEnrichmentCustomOperations;
using ArchiSharp.Core.Extensions.GeometryExtensions;

namespace $rootnamespace$
{
    public class $fileinputname$Request : BaseEnrichmentCustomRequest 
    {
        /// <summary>
        /// You comment about the property goes here...
        /// </summary>
        [CustomRequestField(
            id: "$guid2$", // IMP > Every CustomRequestFieldId ("id") must be a new/random/unique guid
            description: "Sample input property with <int> value...",
            fieldType: CustomRequestFieldTypes.Input,
            fieldSelectType: CustomRequestFieldSelectTypes.Value,
            required: true
        )]
        public int PropertySampleIntValue { get; set; }
    }
}