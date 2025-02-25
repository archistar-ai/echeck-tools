using System;
using Microsoft.Extensions.Logging;
using ECheck.Core.Abstraction.Attributes;
using ECheck.Core.Logic.ModelEnrichmentCustom.ModelEnrichmentCustomOperations;
using ECheck.Core.Models.Objects;

namespace $rootnamespace$
{
    [CustomOperation(id: "$guid1$", order: 1)] // IMP > Every CustomOperationId ("id") must be a new/random/unique guid
    public class $fileinputname$Operation_latest : BaseECheckCustomOperation<$fileinputname$Request> // Sample and only for usage demo
    {
        public $fileinputname$Operation_latest(ILogger<$fileinputname$Request> logger) : base(logger)
        {
        }

        public override BaseEnrichmentCustomRequest Calculate(ModelSiteEnvelope modelSiteEnvelope, $fileinputname$Request request, string requestName, Guid operationId)
        {
            // Your CustomOperation logic goes here ...

                // Do {code} ...

            // Your CustomOperation logic goes here ...

            return request;
        }

        public override IDictionary<string, $fileinputname$Request> HardCodedRequests(IList<int> documentIds, int? certificateId)
        {
            var developmentRequests = new Dictionary<string, $fileinputname$Request>
            {
                { "DevelopmentRequest_01", new $fileinputname$Request{} },
                { "DevelopmentRequest_02", new $fileinputname$Request{} },
            };

            return developmentRequests;
        }
    }
}
